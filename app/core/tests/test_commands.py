"""
Test custom Django management commands.
"""
from unittest.mock import patch

from psycopg2 import OperationalError as Psycopg2OpError

from django.core.management import call_command
from django.db.utils import OperationalError
from django.test import SimpleTestCase


@patch("core.management.commands.wait_for_db.Command.check")
class CommandTests(SimpleTestCase):
    """Test commands."""

    def test_wait_for_db_ready(self, patched_check):
        """Test waiting for database if database ready."""
        patched_check.return_value = True

        call_command("wait_for_db")

        # Here, the function should be called once with the defined parameter
        patched_check.assert_called_once_with(databases=["default"])

    @patch("time.sleep")
    def test_wait_for_db_delay(self, patched_sleep, patched_check):
        """Test waiting for database when getting OperationalError."""

        # Here, the first two times the function is called, it'll return a
        # Psycopg2OpError. Then, for three times, it'll return an
        # OperationalError. Finally, it'll return True
        patched_check.side_effect = (
            [Psycopg2OpError] * 2 + [OperationalError] * 3 + [True]
        )

        call_command("wait_for_db")

        # Here, the function will be called six times (5 errors and 1 True)
        self.assertEqual(patched_check.call_count, 6)

        # Verifying the provided parameters to the function call
        patched_check.assert_called_with(databases=["default"])
