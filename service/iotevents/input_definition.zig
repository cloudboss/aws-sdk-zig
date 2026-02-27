const Attribute = @import("attribute.zig").Attribute;

/// The definition of the input.
pub const InputDefinition = struct {
    /// The attributes from the JSON payload that are made available by the input.
    /// Inputs are
    /// derived from messages sent to the AWS IoT Events system using
    /// `BatchPutMessage`. Each such
    /// message contains a JSON payload, and those attributes (and their paired
    /// values) specified here
    /// are available for use in the `condition` expressions used by detectors that
    /// monitor
    /// this input.
    attributes: []const Attribute,

    pub const json_field_names = .{
        .attributes = "attributes",
    };
};
