const aws = @import("aws");

const Parameter = @import("parameter.zig").Parameter;

/// The parameters in the API request body.
pub const RequestBody = struct {
    /// The content in the request body.
    content: ?[]const aws.map.MapEntry([]const Parameter),

    pub const json_field_names = .{
        .content = "content",
    };
};
