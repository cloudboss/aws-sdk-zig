/// Represents input information for uploading a file to a benefit application.
pub const FileInput = struct {
    /// The business purpose or use case that this file supports in the benefit
    /// application.
    business_use_case: ?[]const u8,

    /// The URI or location where the file should be stored or has been uploaded.
    file_uri: []const u8,

    pub const json_field_names = .{
        .business_use_case = "BusinessUseCase",
        .file_uri = "FileURI",
    };
};
