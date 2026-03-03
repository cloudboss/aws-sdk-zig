const aws = @import("aws");

const CreatedByInfo = @import("created_by_info.zig").CreatedByInfo;
const FileStatusType = @import("file_status_type.zig").FileStatusType;
const FileUseCaseType = @import("file_use_case_type.zig").FileUseCaseType;

/// Information about the attached file.
pub const AttachedFile = struct {
    /// The resource to which the attached file is (being) uploaded to.
    /// [Cases](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_CreateCase.html) are the only current supported
    /// resource.
    ///
    /// This value must be a valid ARN.
    associated_resource_arn: ?[]const u8 = null,

    /// Represents the identity that created the file.
    created_by: ?CreatedByInfo = null,

    /// The time of Creation of the file resource as an ISO timestamp. It's
    /// specified in ISO 8601 format:
    /// `yyyy-MM-ddThh:mm:ss.SSSZ`. For example, `2024-05-03T02:41:28.172Z`.
    creation_time: []const u8,

    /// The unique identifier of the attached file resource (ARN).
    file_arn: []const u8,

    /// The unique identifier of the attached file resource.
    file_id: []const u8,

    /// A case-sensitive name of the attached file being uploaded.
    file_name: []const u8,

    /// The size of the attached file in bytes.
    file_size_in_bytes: i64,

    /// The current status of the attached file.
    file_status: FileStatusType,

    /// The use case for the file.
    file_use_case_type: ?FileUseCaseType = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "Tags":
    /// {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .file_arn = "FileArn",
        .file_id = "FileId",
        .file_name = "FileName",
        .file_size_in_bytes = "FileSizeInBytes",
        .file_status = "FileStatus",
        .file_use_case_type = "FileUseCaseType",
        .tags = "Tags",
    };
};
