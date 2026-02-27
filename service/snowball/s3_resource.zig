const KeyRange = @import("key_range.zig").KeyRange;
const TargetOnDeviceService = @import("target_on_device_service.zig").TargetOnDeviceService;

/// Each `S3Resource` object represents an Amazon S3 bucket that your
/// transferred data will be exported from or imported into. For export jobs,
/// this object can have
/// an optional `KeyRange` value. The length of the range is defined at job
/// creation,
/// and has either an inclusive `BeginMarker`, an inclusive `EndMarker`, or
/// both. Ranges are UTF-8 binary sorted.
pub const S3Resource = struct {
    /// The Amazon Resource Name (ARN) of an Amazon S3 bucket.
    bucket_arn: ?[]const u8,

    /// For export jobs, you can provide an optional `KeyRange` within a specific
    /// Amazon S3 bucket. The length of the range is defined at job creation, and
    /// has either an
    /// inclusive `BeginMarker`, an inclusive `EndMarker`, or both. Ranges are
    /// UTF-8 binary sorted.
    key_range: ?KeyRange,

    /// Specifies the service or services on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into. Amazon Web Services Snow Family
    /// supports Amazon S3 and NFS (Network File
    /// System).
    target_on_device_services: ?[]const TargetOnDeviceService,

    pub const json_field_names = .{
        .bucket_arn = "BucketArn",
        .key_range = "KeyRange",
        .target_on_device_services = "TargetOnDeviceServices",
    };
};
