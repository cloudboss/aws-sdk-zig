const EventInfo = @import("event_info.zig").EventInfo;
const VendorName = @import("vendor_name.zig").VendorName;

/// Metadata that is associated with a code review. This applies to both pull
/// request and
/// repository analysis code reviews.
pub const RequestMetadata = struct {
    /// Information about the event associated with a code review.
    event_info: ?EventInfo,

    /// An identifier, such as a name or account ID, that is associated with the
    /// requester. The
    /// `Requester` is used to capture the `author/actor` name of the
    /// event request.
    requester: ?[]const u8,

    /// The ID of the request. This is required for a pull request code review.
    request_id: ?[]const u8,

    /// The name of the repository vendor used to upload code to an S3 bucket for a
    /// CI/CD code
    /// review. For example, if code and artifacts are uploaded to an S3 bucket for
    /// a CI/CD code
    /// review by GitHub scripts from a GitHub repository, then the repository
    /// association's
    /// `ProviderType` is `S3Bucket` and the CI/CD repository vendor name
    /// is GitHub. For more information, see the definition for `ProviderType` in
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html).
    vendor_name: ?VendorName,

    pub const json_field_names = .{
        .event_info = "EventInfo",
        .requester = "Requester",
        .request_id = "RequestId",
        .vendor_name = "VendorName",
    };
};
