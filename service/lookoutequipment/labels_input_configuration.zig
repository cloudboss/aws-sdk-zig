const LabelsS3InputConfiguration = @import("labels_s3_input_configuration.zig").LabelsS3InputConfiguration;

/// Contains the configuration information for the S3 location being used to
/// hold label
/// data.
pub const LabelsInputConfiguration = struct {
    /// The name of the label group to be used for label data.
    label_group_name: ?[]const u8 = null,

    /// Contains location information for the S3 location being used for label data.
    s3_input_configuration: ?LabelsS3InputConfiguration = null,

    pub const json_field_names = .{
        .label_group_name = "LabelGroupName",
        .s3_input_configuration = "S3InputConfiguration",
    };
};
