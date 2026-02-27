const Parameter = @import("parameter.zig").Parameter;

/// Contains the parameters in the request body.
pub const PropertyParameters = struct {
    /// A list of parameters in the request body.
    properties: ?[]const Parameter,

    pub const json_field_names = .{
        .properties = "properties",
    };
};
