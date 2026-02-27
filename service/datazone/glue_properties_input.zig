const GlueConnectionInput = @import("glue_connection_input.zig").GlueConnectionInput;

/// The Amazon Web Services Glue properties of a connection.
pub const GluePropertiesInput = struct {
    /// The Amazon Web Services Glue connection.
    glue_connection_input: ?GlueConnectionInput,

    pub const json_field_names = .{
        .glue_connection_input = "glueConnectionInput",
    };
};
