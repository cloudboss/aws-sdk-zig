const S3Location = @import("s3_location.zig").S3Location;

/// The source code configuration that specifies the location and details of the
/// code to be executed.
pub const Code = union(enum) {
    /// The Amazon Amazon S3 object that contains the source code for the agent
    /// runtime.
    s_3: ?S3Location,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
