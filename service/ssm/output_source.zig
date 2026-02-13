/// Information about the source where the association execution details are
/// stored.
pub const OutputSource = struct {
    /// The ID of the output source, for example the URL of an S3 bucket.
    output_source_id: ?[]const u8,

    /// The type of source where the association execution details are stored, for
    /// example, Amazon S3.
    output_source_type: ?[]const u8,

    pub const json_field_names = .{
        .output_source_id = "OutputSourceId",
        .output_source_type = "OutputSourceType",
    };
};
