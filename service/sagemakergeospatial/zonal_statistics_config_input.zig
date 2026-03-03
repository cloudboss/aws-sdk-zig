const ZonalStatistics = @import("zonal_statistics.zig").ZonalStatistics;

/// The structure representing input configuration of ZonalStatistics operation.
pub const ZonalStatisticsConfigInput = struct {
    /// List of zonal statistics to compute.
    statistics: []const ZonalStatistics,

    /// Bands used in the operation.
    /// If no target bands are specified, it uses all bands available input.
    target_bands: ?[]const []const u8 = null,

    /// The Amazon S3 path pointing to the GeoJSON containing the polygonal zones.
    zone_s3_path: []const u8,

    /// The Amazon Resource Name (ARN) or an ID of a Amazon Web Services Key
    /// Management Service (Amazon Web Services KMS) key that Amazon SageMaker uses
    /// to decrypt your output artifacts with Amazon S3 server-side encryption.
    /// The SageMaker execution role must have `kms:GenerateDataKey` permission.
    ///
    /// The `KmsKeyId` can be any of the following formats:
    ///
    /// * // KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * // Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:<region>:<account>:key/<key-id-12ab-34cd-56ef-1234567890ab>"`
    ///
    /// For more information about key identifiers, see
    /// [Key identifiers
    /// (KeyID)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-id) in the
    /// Amazon Web Services Key Management Service (Amazon Web Services KMS)
    /// documentation.
    zone_s3_path_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .statistics = "Statistics",
        .target_bands = "TargetBands",
        .zone_s3_path = "ZoneS3Path",
        .zone_s3_path_kms_key_id = "ZoneS3PathKmsKeyId",
    };
};
