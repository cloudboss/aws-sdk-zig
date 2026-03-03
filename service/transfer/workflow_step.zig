const CopyStepDetails = @import("copy_step_details.zig").CopyStepDetails;
const CustomStepDetails = @import("custom_step_details.zig").CustomStepDetails;
const DecryptStepDetails = @import("decrypt_step_details.zig").DecryptStepDetails;
const DeleteStepDetails = @import("delete_step_details.zig").DeleteStepDetails;
const TagStepDetails = @import("tag_step_details.zig").TagStepDetails;
const WorkflowStepType = @import("workflow_step_type.zig").WorkflowStepType;

/// The basic building block of a workflow.
pub const WorkflowStep = struct {
    /// Details for a step that performs a file copy.
    ///
    /// Consists of the following values:
    ///
    /// * A description
    /// * An Amazon S3 location for the destination of the file copy.
    /// * A flag that indicates whether to overwrite an existing file of the same
    ///   name. The default is `FALSE`.
    copy_step_details: ?CopyStepDetails = null,

    /// Details for a step that invokes an Lambda function.
    ///
    /// Consists of the Lambda function's name, target, and timeout (in seconds).
    custom_step_details: ?CustomStepDetails = null,

    /// Details for a step that decrypts an encrypted file.
    ///
    /// Consists of the following values:
    ///
    /// * A descriptive name
    /// * An Amazon S3 or Amazon Elastic File System (Amazon EFS) location for the
    ///   source file to decrypt.
    /// * An S3 or Amazon EFS location for the destination of the file decryption.
    /// * A flag that indicates whether to overwrite an existing file of the same
    ///   name. The default is `FALSE`.
    /// * The type of encryption that's used. Currently, only PGP encryption is
    ///   supported.
    decrypt_step_details: ?DecryptStepDetails = null,

    /// Details for a step that deletes the file.
    delete_step_details: ?DeleteStepDetails = null,

    /// Details for a step that creates one or more tags.
    ///
    /// You specify one or more tags. Each tag contains a key-value pair.
    tag_step_details: ?TagStepDetails = null,

    /// Currently, the following step types are supported.
    ///
    /// * ** `COPY` ** - Copy the file to another location.
    /// * ** `CUSTOM` ** - Perform a custom step with an Lambda function target.
    /// * ** `DECRYPT` ** - Decrypt a file that was encrypted before it was
    ///   uploaded.
    /// * ** `DELETE` ** - Delete the file.
    /// * ** `TAG` ** - Add a tag to the file.
    @"type": ?WorkflowStepType = null,

    pub const json_field_names = .{
        .copy_step_details = "CopyStepDetails",
        .custom_step_details = "CustomStepDetails",
        .decrypt_step_details = "DecryptStepDetails",
        .delete_step_details = "DeleteStepDetails",
        .tag_step_details = "TagStepDetails",
        .@"type" = "Type",
    };
};
