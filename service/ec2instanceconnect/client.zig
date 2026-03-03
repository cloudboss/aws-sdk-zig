const aws = @import("aws");
const std = @import("std");

const send_serial_console_ssh_public_key = @import("send_serial_console_ssh_public_key.zig");
const send_ssh_public_key = @import("send_ssh_public_key.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EC2 Instance Connect";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Pushes an SSH public key to the specified EC2 instance. The key remains for
    /// 60
    /// seconds, which gives you 60 seconds to establish a serial console connection
    /// to the
    /// instance using SSH. For more information, see [EC2 Serial
    /// Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-serial-console.html) in
    /// the *Amazon EC2 User Guide*.
    pub fn sendSerialConsoleSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: send_serial_console_ssh_public_key.SendSerialConsoleSSHPublicKeyInput, options: send_serial_console_ssh_public_key.Options) !send_serial_console_ssh_public_key.SendSerialConsoleSSHPublicKeyOutput {
        return send_serial_console_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Pushes an SSH public key to the specified EC2 instance for use by the
    /// specified user.
    /// The key remains for 60 seconds. For more information, see [Connect to
    /// your Linux instance using EC2 Instance
    /// Connect](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect.html) in the *Amazon EC2
    /// User Guide*.
    pub fn sendSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: send_ssh_public_key.SendSSHPublicKeyInput, options: send_ssh_public_key.Options) !send_ssh_public_key.SendSSHPublicKeyOutput {
        return send_ssh_public_key.execute(self, allocator, input, options);
    }
};
