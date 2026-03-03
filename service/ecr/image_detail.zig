const ImageScanFindingsSummary = @import("image_scan_findings_summary.zig").ImageScanFindingsSummary;
const ImageScanStatus = @import("image_scan_status.zig").ImageScanStatus;
const ImageStatus = @import("image_status.zig").ImageStatus;

/// An object that describes an image returned by a DescribeImages
/// operation.
pub const ImageDetail = struct {
    /// The artifact media type of the image.
    artifact_media_type: ?[]const u8 = null,

    /// The `sha256` digest of the image manifest.
    image_digest: ?[]const u8 = null,

    /// The media type of the image manifest.
    image_manifest_media_type: ?[]const u8 = null,

    /// The date and time, expressed in standard JavaScript date format, at which
    /// the current
    /// image was pushed to the repository.
    image_pushed_at: ?i64 = null,

    /// A summary of the last completed image scan.
    image_scan_findings_summary: ?ImageScanFindingsSummary = null,

    /// The current state of the scan.
    image_scan_status: ?ImageScanStatus = null,

    /// The size, in bytes, of the image in the repository.
    ///
    /// If the image is a manifest list, this will be the max size of all manifests
    /// in the
    /// list.
    ///
    /// Starting with Docker version 1.9, the Docker client compresses image layers
    /// before
    /// pushing them to a V2 Docker registry. The output of the `docker images`
    /// command shows the uncompressed image size. Therefore, Docker might return a
    /// larger
    /// image than the image shown in the Amazon Web Services Management Console.
    image_size_in_bytes: ?i64 = null,

    /// The current status of the image.
    image_status: ?ImageStatus = null,

    /// The list of tags associated with this image.
    image_tags: ?[]const []const u8 = null,

    /// The date and time, expressed in standard JavaScript date format, when the
    /// image was last restored from Amazon ECR archive to Amazon ECR standard.
    last_activated_at: ?i64 = null,

    /// The date and time, expressed in standard JavaScript date format, when the
    /// image was last transitioned to Amazon ECR archive.
    last_archived_at: ?i64 = null,

    /// The date and time, expressed in standard JavaScript date format, when Amazon
    /// ECR recorded
    /// the last image pull.
    ///
    /// Amazon ECR refreshes the last image pull timestamp at least once every 24
    /// hours. For
    /// example, if you pull an image once a day then the `lastRecordedPullTime`
    /// timestamp will indicate the exact time that the image was last pulled.
    /// However, if
    /// you pull an image once an hour, because Amazon ECR refreshes the
    /// `lastRecordedPullTime` timestamp at least once every 24 hours, the
    /// result may not be the exact time that the image was last pulled.
    last_recorded_pull_time: ?i64 = null,

    /// The Amazon Web Services account ID associated with the registry to which
    /// this image belongs.
    registry_id: ?[]const u8 = null,

    /// The name of the repository to which this image belongs.
    repository_name: ?[]const u8 = null,

    /// The digest of the subject manifest for images that are referrers.
    subject_manifest_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_media_type = "artifactMediaType",
        .image_digest = "imageDigest",
        .image_manifest_media_type = "imageManifestMediaType",
        .image_pushed_at = "imagePushedAt",
        .image_scan_findings_summary = "imageScanFindingsSummary",
        .image_scan_status = "imageScanStatus",
        .image_size_in_bytes = "imageSizeInBytes",
        .image_status = "imageStatus",
        .image_tags = "imageTags",
        .last_activated_at = "lastActivatedAt",
        .last_archived_at = "lastArchivedAt",
        .last_recorded_pull_time = "lastRecordedPullTime",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .subject_manifest_digest = "subjectManifestDigest",
    };
};
