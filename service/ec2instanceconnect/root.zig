pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const SendSSHPublicKeyInput = @import("send_ssh_public_key.zig").SendSSHPublicKeyInput;
pub const SendSSHPublicKeyOutput = @import("send_ssh_public_key.zig").SendSSHPublicKeyOutput;
pub const SendSerialConsoleSSHPublicKeyInput = @import("send_serial_console_ssh_public_key.zig").SendSerialConsoleSSHPublicKeyInput;
pub const SendSerialConsoleSSHPublicKeyOutput = @import("send_serial_console_ssh_public_key.zig").SendSerialConsoleSSHPublicKeyOutput;
