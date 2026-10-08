"""Test service selection from AWS model metadata."""

import json
import os
from pathlib import Path
import runpy
import tempfile
import unittest
from unittest.mock import patch


with patch.dict(os.environ, {"AWS_MODELS_COMMIT": "test"}):
    scan_models = runpy.run_path(
        str(Path(__file__).with_name("generate-service-configs"))
    )["scan_models"]


class ServiceSelectionTest(unittest.TestCase):
    def test_internal_services_are_excluded(self):
        cases = {
            "internal-trait": {"smithy.api#internal": {}},
            "lambda-web": {
                "smithy.api#documentation": (
                    "<p>The AWS Lambda Web Functions APIs (<code>LambdaWeb</code> namespace) "
                    "are experimental and for internal AWS use only. They are not yet "
                    "available to external customers.</p>"
                ),
            },
            "unavailable": {
                "smithy.api#documentation": (
                    "<p>This service is NOT&nbsp;AVAILABLE to external customers.</p>"
                ),
            },
        }
        with tempfile.TemporaryDirectory() as directory:
            for name, traits in cases.items():
                self.write_model(directory, name, traits)
            services, skipped = scan_models(directory)
        self.assertEqual([], services)
        self.assertEqual(
            [(name, "internal use only") for name in sorted(cases)], skipped
        )

    def test_public_services_keep_internal_networks_and_internal_operations(self):
        with tempfile.TemporaryDirectory() as directory:
            self.write_model(
                directory,
                "lambda-core",
                {
                    "smithy.api#documentation": (
                        "Network connectors let customers access databases and internal APIs."
                    ),
                },
                {
                    "test#InternalOperation": {
                        "type": "operation",
                        "traits": {"smithy.api#internal": {}},
                    },
                },
            )
            services, skipped = scan_models(directory)
        self.assertEqual(
            [
                (
                    "lambdacore",
                    "lambda-core",
                    "models/lambda-core/service/2025-01-01/lambda-core-2025-01-01.json",
                    "test#Service",
                ),
            ],
            services,
        )
        self.assertEqual([], skipped)

    def test_rpcv2_only_services_remain_excluded(self):
        with tempfile.TemporaryDirectory() as directory:
            self.write_model(directory, "cbor", {"smithy.protocols#rpcv2Cbor": {}})
            services, skipped = scan_models(directory)
        self.assertEqual([], services)
        self.assertEqual([("cbor", "rpcv2Cbor only")], skipped)

    @staticmethod
    def write_model(directory, name, traits, definitions=None):
        date = "2025-01-01"
        destination = Path(directory) / name / "service" / date
        destination.mkdir(parents=True)
        model = {
            "smithy": "2.0",
            "shapes": {
                "test#Service": {
                    "type": "service",
                    "version": "1",
                    "traits": {"aws.protocols#restJson1": {}, **traits},
                },
                **(definitions or {}),
            },
        }
        if "smithy.protocols#rpcv2Cbor" in traits:
            del model["shapes"]["test#Service"]["traits"]["aws.protocols#restJson1"]
        (destination / f"{name}-{date}.json").write_text(
            json.dumps(model), encoding="utf-8"
        )


if __name__ == "__main__":
    unittest.main()
