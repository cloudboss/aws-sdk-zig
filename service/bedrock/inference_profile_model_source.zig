/// Contains information about the model or system-defined inference profile
/// that is the source for an inference profile..
pub const InferenceProfileModelSource = union(enum) {
    /// The ARN of the model or system-defined inference profile that is the source
    /// for the inference profile.
    copy_from: ?[]const u8,

    pub const json_field_names = .{
        .copy_from = "copyFrom",
    };
};
