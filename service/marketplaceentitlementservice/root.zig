pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const GetEntitlementsInput = @import("get_entitlements.zig").GetEntitlementsInput;
pub const GetEntitlementsOutput = @import("get_entitlements.zig").GetEntitlementsOutput;
