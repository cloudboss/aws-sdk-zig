/// Provides information about an S3 object that Amazon Macie selected for
/// analysis while performing automated sensitive data discovery for an account,
/// and the status and results of the analysis. This information is available
/// only if automated sensitive data discovery has been enabled for the account.
pub const ResourceProfileArtifact = struct {
    /// The Amazon Resource Name (ARN) of the object.
    arn: []const u8,

    /// The status of the analysis. Possible values are:
    ///
    /// * COMPLETE - Amazon Macie successfully completed its analysis of the object.
    /// * PARTIAL - Macie analyzed only a subset of data in the object. For example,
    ///   the object is an archive file that contains files in an unsupported
    ///   format.
    /// * SKIPPED - Macie wasn't able to analyze the object. For example, the object
    ///   is a malformed file.
    classification_result_status: []const u8,

    /// Specifies whether Amazon Macie found sensitive data in the object.
    sensitive: ?bool,

    pub const json_field_names = .{
        .arn = "arn",
        .classification_result_status = "classificationResultStatus",
        .sensitive = "sensitive",
    };
};
