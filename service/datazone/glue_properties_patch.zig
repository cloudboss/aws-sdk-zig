const GlueConnectionPatch = @import("glue_connection_patch.zig").GlueConnectionPatch;

/// The Amazon Web Services Glue properties patch of a connection.
pub const GluePropertiesPatch = struct {
    /// The Amazon Web Services Glue properties patch of a connection.
    glue_connection_input: ?GlueConnectionPatch = null,

    pub const json_field_names = .{
        .glue_connection_input = "glueConnectionInput",
    };
};
