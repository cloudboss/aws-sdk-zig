#!/usr/bin/env python3
"""
Host-side mock IMDS server for integration tests.
Runs on host, accessible from VM via QEMU's gateway (10.0.2.2).

Emulates IMDSv2 behavior:
- PUT /latest/api/token requires X-aws-ec2-metadata-token-ttl-seconds header
- PUT /latest/api/token rejects requests with X-Forwarded-For header
- GET requests require valid X-aws-ec2-metadata-token header
- Uses HTTP/1.1 with keep-alive (like real IMDS)
- Returns proper error codes: 400, 401, 403, 404
"""

import http.server
import json
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

TOKEN = "mock-imds-token-12345"
TOKEN_TTL = 21600

# Defaults; overridden by sys.argv in __main__ block.
PORT = 8080
SCENARIOS_DIR = Path("scenarios")
SCENARIO = "basic-boot"
NIC_COUNT = 1
SPOT_TERMINATION_DELAY = 0

# Track server start time for spot termination simulation
SERVER_START_TIME = time.time()

# Generate MACs for each NIC (QEMU style: 52:54:00:12:34:XX)
def generate_macs(count):
    """Generate sequential MAC addresses starting from QEMU default."""
    macs = []
    for i in range(count):
        macs.append(f"52:54:00:12:34:{86 + i:02x}")
    return macs

MACS = generate_macs(NIC_COUNT)

# Static metadata responses
METADATA = {
    "instance-id": "i-test12345",
    "local-hostname": "test-host",
    "ami-id": "ami-test12345",
    "instance-type": "t3.micro",
    "placement/availability-zone": "us-east-1a",
    "placement/region": "us-east-1",
    "public-keys/": "0=test-key",
    "public-keys/0/openssh-key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0test-key test@example.com",
}

# Mock IAM role and credentials
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


class IMDSHandler(http.server.BaseHTTPRequestHandler):
    # Use HTTP/1.1 like real IMDS
    protocol_version = "HTTP/1.1"

    def log_message(self, fmt, *args):
        print(f"IMDS: {fmt % args}", file=sys.stderr, flush=True)

    def _send_text(self, code, content_bytes, content_type="text/plain"):
        """Send a response with proper headers."""
        self.send_response(code)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(content_bytes)))
        self.end_headers()
        self.wfile.write(content_bytes)

    def _send_error_response(self, code, message=""):
        """Send an error response matching IMDS behavior."""
        self.send_response(code)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(message)))
        self.end_headers()
        if message:
            self.wfile.write(message.encode())

    def _validate_token(self):
        """Validate the IMDSv2 session token on GET requests.
        Returns True if valid, sends 401 and returns False otherwise."""
        token = self.headers.get("X-aws-ec2-metadata-token")
        if token is None:
            print("IMDS: GET rejected: missing X-aws-ec2-metadata-token header", file=sys.stderr, flush=True)
            self._send_error_response(401, "Unauthorized")
            return False
        if token != TOKEN:
            print(f"IMDS: GET rejected: invalid token (got {repr(token)}, expected {repr(TOKEN)})", file=sys.stderr, flush=True)
            self._send_error_response(401, "Unauthorized")
            return False
        return True

    def do_PUT(self):
        """Handle IMDSv2 token request."""
        if self.path == "/latest/api/token":
            # Real IMDS rejects PUT with X-Forwarded-For header
            if self.headers.get("X-Forwarded-For") is not None:
                print("IMDS: PUT rejected: X-Forwarded-For header present", file=sys.stderr, flush=True)
                self._send_error_response(403, "Forbidden")
                return

            # Real IMDS requires the TTL header
            ttl_header = self.headers.get("X-aws-ec2-metadata-token-ttl-seconds")
            if ttl_header is None:
                print("IMDS: PUT rejected: missing X-aws-ec2-metadata-token-ttl-seconds header", file=sys.stderr, flush=True)
                self._send_error_response(400, "Missing or Invalid Parameters - TTL")
                return

            # Validate TTL is a valid integer between 1 and 21600
            try:
                ttl = int(ttl_header)
                if ttl < 1 or ttl > 21600:
                    raise ValueError("out of range")
            except ValueError:
                print(f"IMDS: PUT rejected: invalid TTL value: {repr(ttl_header)}", file=sys.stderr, flush=True)
                self._send_error_response(400, "Missing or Invalid Parameters - TTL")
                return

            token_bytes = TOKEN.encode()
            print(f"IMDS: PUT /latest/api/token TTL={ttl} -> token ({len(token_bytes)} bytes)", file=sys.stderr, flush=True)
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(token_bytes)))
            self.send_header("X-aws-ec2-metadata-token-ttl-seconds", str(ttl))
            self.end_headers()
            self.wfile.write(token_bytes)
        elif self.path.startswith("/") and "/api/token" in self.path:
            # Version-specific token paths return 403
            print(f"IMDS: PUT rejected: version-specific path {self.path}", file=sys.stderr, flush=True)
            self._send_error_response(403, "Forbidden")
        else:
            self._send_error_response(404, "Not Found")

    def do_GET(self):
        """Handle metadata requests with token validation."""
        # Validate IMDSv2 token
        if not self._validate_token():
            return

        path = self.path.lstrip("/")

        # User data (content-type is application/octet-stream per AWS docs)
        if path == "latest/user-data":
            user_data_file = SCENARIOS_DIR / SCENARIO / "user-data.yaml"
            if user_data_file.is_file():
                content = user_data_file.read_bytes()
                self._send_text(200, content, "application/octet-stream")
            else:
                self._send_error_response(404, "Not Found")
            return

        # Strip latest/meta-data/ prefix
        if path.startswith("latest/meta-data/"):
            meta_path = path[len("latest/meta-data/"):]
        elif path.startswith("latest/dynamic/"):
            meta_path = path[len("latest/"):]
        else:
            self._send_error_response(404, "Not Found")
            return

        # Network interface queries - respond to any MAC
        if meta_path.startswith("network/interfaces/macs/"):
            self._handle_network_metadata(meta_path)
            return

        # IAM credentials
        if meta_path.startswith("iam/"):
            self._handle_iam_metadata(meta_path)
            return

        # Spot termination notices
        if meta_path.startswith("spot/"):
            self._handle_spot_metadata(meta_path)
            return

        # Dynamic instance identity document
        if meta_path == "dynamic/instance-identity/document":
            doc = {
                "accountId": "123456789012",
                "architecture": "x86_64",
                "availabilityZone": "us-east-1a",
                "billingProducts": None,
                "devpayProductCodes": None,
                "marketplaceProductCodes": None,
                "imageId": "ami-test12345",
                "instanceId": "i-test12345",
                "instanceType": "t3.micro",
                "kernelId": None,
                "pendingTime": "2024-01-01T00:00:00Z",
                "privateIp": "10.0.2.15",
                "ramdiskId": None,
                "region": "us-east-1",
                "version": "2017-09-30",
            }
            content = json.dumps(doc).encode()
            self._send_text(200, content, "application/json")
            return

        # Static metadata
        if meta_path in METADATA:
            content = METADATA[meta_path].encode()
            self._send_text(200, content)
        else:
            self._send_error_response(404, "Not Found")

    def _handle_network_metadata(self, meta_path):
        """Handle network interface metadata queries."""
        parts = meta_path.split("/")
        # network/interfaces/macs/<mac>/...

        # List MACs: network/interfaces/macs/
        if meta_path == "network/interfaces/macs/" or meta_path == "network/interfaces/macs":
            # Return all configured MACs
            content = "\n".join(f"{mac}/" for mac in MACS).encode()
            self._send_text(200, content)
            return

        if len(parts) >= 5:
            mac = parts[3]
            attr = "/".join(parts[4:])

            # Find device number for this MAC
            try:
                device_num = MACS.index(mac)
            except ValueError:
                # Unknown MAC - return 404
                self._send_error_response(404, "Not Found")
                return

            # Per-interface responses
            responses = {
                "device-number": str(device_num),
                "local-ipv4s": f"10.0.2.{15 + device_num}",
                "subnet-id": f"subnet-test{device_num}",
                "vpc-id": "vpc-test123",
            }

            if attr in responses:
                content = responses[attr].encode()
                self._send_text(200, content)
                return

        self._send_error_response(404, "Not Found")

    def _handle_iam_metadata(self, meta_path):
        """Handle IAM credential metadata queries."""
        # iam/security-credentials/ - list roles
        if meta_path in ("iam/security-credentials/", "iam/security-credentials"):
            content = IAM_ROLE.encode()
            self._send_text(200, content)
            return

        # iam/security-credentials/<role-name> - get credentials
        if meta_path == f"iam/security-credentials/{IAM_ROLE}":
            content = json.dumps(IAM_CREDENTIALS).encode()
            self._send_text(200, content, "application/json")
            return

        self._send_error_response(404, "Not Found")

    def _handle_spot_metadata(self, meta_path):
        """Handle spot instance metadata queries."""
        # spot/instance-action - termination notice
        if meta_path in ("spot/instance-action", "spot/instance-action/"):
            # Check if we should simulate termination
            if SPOT_TERMINATION_DELAY > 0:
                elapsed = time.time() - SERVER_START_TIME
                if elapsed >= SPOT_TERMINATION_DELAY:
                    # Return termination notice
                    termination_time = datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
                    response = {
                        "action": "terminate",
                        "time": termination_time,
                    }
                    content = json.dumps(response).encode()
                    print(f"IMDS: Returning spot termination notice: {response}", file=sys.stderr, flush=True)
                    self._send_text(200, content, "application/json")
                    return

            # No termination scheduled - return 404
            self._send_error_response(404, "Not Found")
            return

        self._send_error_response(404, "Not Found")


if __name__ == "__main__":
    PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
    SCENARIOS_DIR = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("scenarios")
    SCENARIO = sys.argv[3] if len(sys.argv) > 3 else "basic-boot"
    NIC_COUNT = int(sys.argv[4]) if len(sys.argv) > 4 else 1
    SPOT_TERMINATION_DELAY = int(sys.argv[5]) if len(sys.argv) > 5 else 0
    MACS = generate_macs(NIC_COUNT)

    print(f"Mock IMDS server starting on 0.0.0.0:{PORT}", file=sys.stderr, flush=True)
    print(f"Scenarios dir: {SCENARIOS_DIR}", file=sys.stderr, flush=True)
    print(f"Current scenario: {SCENARIO}", file=sys.stderr, flush=True)
    print(f"NIC count: {NIC_COUNT}, MACs: {MACS}", file=sys.stderr, flush=True)
    if SPOT_TERMINATION_DELAY > 0:
        print(f"Spot termination: will trigger after {SPOT_TERMINATION_DELAY}s", file=sys.stderr, flush=True)
    else:
        print(f"Spot termination: disabled", file=sys.stderr, flush=True)

    server = http.server.HTTPServer(("0.0.0.0", PORT), IMDSHandler)
    server.serve_forever()
