pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const CreateTokenInput = @import("create_token.zig").CreateTokenInput;
pub const CreateTokenOutput = @import("create_token.zig").CreateTokenOutput;
pub const CreateTokenWithIAMInput = @import("create_token_with_iam.zig").CreateTokenWithIAMInput;
pub const CreateTokenWithIAMOutput = @import("create_token_with_iam.zig").CreateTokenWithIAMOutput;
pub const RegisterClientInput = @import("register_client.zig").RegisterClientInput;
pub const RegisterClientOutput = @import("register_client.zig").RegisterClientOutput;
pub const StartDeviceAuthorizationInput = @import("start_device_authorization.zig").StartDeviceAuthorizationInput;
pub const StartDeviceAuthorizationOutput = @import("start_device_authorization.zig").StartDeviceAuthorizationOutput;
