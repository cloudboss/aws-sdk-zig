const Operation = @import("operation.zig").Operation;

pub const TagResourceResult = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation,

    pub const json_field_names = .{
        .operations = "operations",
    };
};
