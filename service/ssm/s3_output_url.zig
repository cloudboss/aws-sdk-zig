/// A URL for the Amazon Web Services Systems Manager (Systems Manager) bucket
/// where you want to store the
/// results of this request.
pub const S3OutputUrl = struct {
    /// A URL for an S3 bucket where you want to store the results of this request.
    output_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_url = "OutputUrl",
    };
};
