const S3OutputUrl = @import("s_3_output_url.zig").S3OutputUrl;

/// The URL of S3 bucket where you want to store the results of this request.
pub const InstanceAssociationOutputUrl = struct {
    /// The URL of S3 bucket where you want to store the results of this request.
    s_3_output_url: ?S3OutputUrl,

    pub const json_field_names = .{
        .s_3_output_url = "S3OutputUrl",
    };
};
