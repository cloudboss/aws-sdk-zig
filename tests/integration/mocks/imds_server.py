#!/usr/bin/env python3
"""
Mock IMDS server for integration tests.
Simplified from easyto-init-zig's version -- only serves endpoints
needed by the aws-sdk-zig IMDS client.
"""

import http.server
import json
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8099
TOKEN = "mock-imds-token-12345"

IAM_ROLE = "test-instance-role"
IAM_CREDENTIALS = {
    "Code": "Success",
    "LastUpdated": "2024-01-01T00:00:00Z",
    "Type": "AWS-HMAC",
    "AccessKeyId": "ASIAIOSFODNN7EXAMPLE",
    "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    "Token": "FwoGZXIvYXdzEBYaDM3fake0token1234567890==",
    "Expiration": "2099-12-31T23:59:59Z",
}

IDENTITY_DOCUMENT = {
    "accountId": "123456789012",
    "architecture": "x86_64",
    "availabilityZone": "us-east-1a",
    "imageId": "ami-test12345",
    "instanceId": "i-test12345",
    "instanceType": "t3.micro",
    "pendingTime": "2024-01-01T00:00:00Z",
    "privateIp": "10.0.0.1",
    "region": "us-east-1",
    "version": "2017-09-30",
}

METADATA = {
    "instance-id": "i-test12345",
    "placement/region": "us-east-1",
}


class IMDSHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):
        print(f"IMDS: {fmt % args}", file=sys.stderr, flush=True)

    def do_PUT(self):
        if self.path == "/latest/api/token":
            token_bytes = TOKEN.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(token_bytes)))
            self.send_header("X-aws-ec2-metadata-token-ttl-seconds", "21600")
            self.end_headers()
            self.wfile.write(token_bytes)
        else:
            self.send_error(404)

    def do_GET(self):
        path = self.path.lstrip("/")

        # Identity document
        if path == "latest/dynamic/instance-identity/document":
            content = json.dumps(IDENTITY_DOCUMENT).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(content)))
            self.end_headers()
            self.wfile.write(content)
            return

        # IAM credentials
        if path.startswith("latest/meta-data/iam/"):
            meta_path = path[len("latest/meta-data/"):]
            self._handle_iam_metadata(meta_path)
            return

        # Static metadata
        if path.startswith("latest/meta-data/"):
            meta_path = path[len("latest/meta-data/"):]
            if meta_path in METADATA:
                content = METADATA[meta_path].encode()
                self.send_response(200)
                self.send_header("Content-Type", "text/plain")
                self.send_header("Content-Length", str(len(content)))
                self.end_headers()
                self.wfile.write(content)
                return

        self.send_error(404)

    def _handle_iam_metadata(self, meta_path):
        if meta_path in ("iam/security-credentials/", "iam/security-credentials"):
            content = IAM_ROLE.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(content)))
            self.end_headers()
            self.wfile.write(content)
            return

        if meta_path == f"iam/security-credentials/{IAM_ROLE}":
            content = json.dumps(IAM_CREDENTIALS).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(content)))
            self.end_headers()
            self.wfile.write(content)
            return

        self.send_error(404)


if __name__ == "__main__":
    print(f"Mock IMDS server starting on 0.0.0.0:{PORT}", file=sys.stderr, flush=True)
    server = http.server.HTTPServer(("0.0.0.0", PORT), IMDSHandler)
    server.serve_forever()
