pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const AssumeRoleForPodIdentityInput = @import("assume_role_for_pod_identity.zig").AssumeRoleForPodIdentityInput;
pub const AssumeRoleForPodIdentityOutput = @import("assume_role_for_pod_identity.zig").AssumeRoleForPodIdentityOutput;
