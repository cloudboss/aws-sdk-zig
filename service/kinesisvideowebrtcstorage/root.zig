pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const JoinStorageSessionAsViewerInput = @import("join_storage_session_as_viewer.zig").JoinStorageSessionAsViewerInput;
pub const JoinStorageSessionInput = @import("join_storage_session.zig").JoinStorageSessionInput;
