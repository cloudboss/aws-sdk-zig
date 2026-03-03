pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const PutAuditEventsInput = @import("put_audit_events.zig").PutAuditEventsInput;
pub const PutAuditEventsOutput = @import("put_audit_events.zig").PutAuditEventsOutput;
