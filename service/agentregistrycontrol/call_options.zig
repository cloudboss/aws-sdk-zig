const errors = @import("errors.zig");

pub const CallOptions = struct {
    diagnostic: ?*errors.ServiceError = null,
};
