const InputFileLocation = @import("input_file_location.zig").InputFileLocation;
const OverwriteExisting = @import("overwrite_existing.zig").OverwriteExisting;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Each step type has its own `StepDetails` structure.
pub const DecryptStepDetails = struct {
    /// Specifies the location for the file being decrypted. Use
    /// `${Transfer:UserName}` or `${Transfer:UploadDate}` in this field to
    /// parametrize the destination prefix by username or uploaded date.
    ///
    /// * Set the value of `DestinationFileLocation` to `${Transfer:UserName}` to
    ///   decrypt uploaded files to an Amazon S3 bucket that is prefixed with the
    ///   name of the Transfer Family user that uploaded the file.
    /// * Set the value of `DestinationFileLocation` to `${Transfer:UploadDate}` to
    ///   decrypt uploaded files to an Amazon S3 bucket that is prefixed with the
    ///   date of the upload.
    ///
    /// The system resolves `UploadDate` to a date format of *YYYY-MM-DD*, based on
    /// the date the file is uploaded in UTC.
    destination_file_location: InputFileLocation,

    /// The name of the step, used as an identifier.
    name: ?[]const u8,

    /// A flag that indicates whether to overwrite an existing file of the same
    /// name. The default is `FALSE`.
    ///
    /// If the workflow is processing a file that has the same name as an existing
    /// file, the behavior is as follows:
    ///
    /// * If `OverwriteExisting` is `TRUE`, the existing file is replaced with the
    ///   file being processed.
    /// * If `OverwriteExisting` is `FALSE`, nothing happens, and the workflow
    ///   processing stops.
    overwrite_existing: ?OverwriteExisting,

    /// Specifies which file to use as input to the workflow step: either the output
    /// from the previous step, or the originally uploaded file for the workflow.
    ///
    /// * To use the previous file as the input, enter `${previous.file}`. In this
    ///   case, this workflow step uses the output file from the previous workflow
    ///   step as input. This is the default value.
    /// * To use the originally uploaded file location as input for this step, enter
    ///   `${original.file}`.
    source_file_location: ?[]const u8,

    /// The type of encryption used. Currently, this value must be `PGP`.
    type: EncryptionType,

    pub const json_field_names = .{
        .destination_file_location = "DestinationFileLocation",
        .name = "Name",
        .overwrite_existing = "OverwriteExisting",
        .source_file_location = "SourceFileLocation",
        .type = "Type",
    };
};
