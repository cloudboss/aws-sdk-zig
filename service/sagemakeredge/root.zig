pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const GetDeploymentsInput = @import("get_deployments.zig").GetDeploymentsInput;
pub const GetDeploymentsOutput = @import("get_deployments.zig").GetDeploymentsOutput;
pub const GetDeviceRegistrationInput = @import("get_device_registration.zig").GetDeviceRegistrationInput;
pub const GetDeviceRegistrationOutput = @import("get_device_registration.zig").GetDeviceRegistrationOutput;
pub const SendHeartbeatInput = @import("send_heartbeat.zig").SendHeartbeatInput;
