const AppSpecContent = @import("app_spec_content.zig").AppSpecContent;
const GitHubLocation = @import("git_hub_location.zig").GitHubLocation;
const RevisionLocationType = @import("revision_location_type.zig").RevisionLocationType;
const S3Location = @import("s3_location.zig").S3Location;
const RawString = @import("raw_string.zig").RawString;

/// Information about the location of an application revision.
pub const RevisionLocation = struct {
    /// The content of an AppSpec file for an Lambda or Amazon ECS
    /// deployment. The content is formatted as JSON or YAML and stored as a
    /// RawString.
    app_spec_content: ?AppSpecContent = null,

    /// Information about the location of application artifacts stored in GitHub.
    git_hub_location: ?GitHubLocation = null,

    /// The type of application revision:
    ///
    /// * S3: An application revision stored in Amazon S3.
    ///
    /// * GitHub: An application revision stored in GitHub (EC2/On-premises
    ///   deployments
    /// only).
    ///
    /// * String: A YAML-formatted or JSON-formatted string (Lambda
    /// deployments only).
    ///
    /// * AppSpecContent: An `AppSpecContent` object that contains the
    /// contents of an AppSpec file for an Lambda or Amazon ECS
    /// deployment. The content is formatted as JSON or YAML stored as a
    /// RawString.
    revision_type: ?RevisionLocationType = null,

    /// Information about the location of a revision stored in Amazon S3.
    s_3_location: ?S3Location = null,

    /// Information about the location of an Lambda deployment revision stored
    /// as a RawString.
    string: ?RawString = null,

    pub const json_field_names = .{
        .app_spec_content = "appSpecContent",
        .git_hub_location = "gitHubLocation",
        .revision_type = "revisionType",
        .s_3_location = "s3Location",
        .string = "string",
    };
};
