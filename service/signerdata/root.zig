pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const GetRevocationStatusInput = @import("get_revocation_status.zig").GetRevocationStatusInput;
pub const GetRevocationStatusOutput = @import("get_revocation_status.zig").GetRevocationStatusOutput;
