const GeneratedTemplateStatus = @import("generated_template_status.zig").GeneratedTemplateStatus;

/// The summary of a generated template.
pub const TemplateSummary = struct {
    /// The time the generated template was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the generated template. The format is
    /// `arn:${Partition}:cloudformation:${Region}:${Account}:generatedtemplate/${Id}`. For
    /// example,
    /// `arn:aws:cloudformation:*us-east-1*:*123456789012*:generatedtemplate/*2e8465c1-9a80-43ea-a3a3-4f2d692fe6dc*
    /// `.
    generated_template_id: ?[]const u8,

    /// The name of the generated template.
    generated_template_name: ?[]const u8,

    /// The time the generated template was last updated.
    last_updated_time: ?i64,

    /// The number of resources in the generated template. This is a total of
    /// resources in pending,
    /// in-progress, completed, and failed states.
    number_of_resources: ?i32,

    /// The status of the template generation. Supported values are:
    ///
    /// * `CreatePending` - the creation of the template is pending.
    ///
    /// * `CreateInProgress` - the creation of the template is in progress.
    ///
    /// * `DeletePending` - the deletion of the template is pending.
    ///
    /// * `DeleteInProgress` - the deletion of the template is in progress.
    ///
    /// * `UpdatePending` - the update of the template is pending.
    ///
    /// * `UpdateInProgress` - the update of the template is in progress.
    ///
    /// * `Failed` - the template operation failed.
    ///
    /// * `Complete` - the template operation is complete.
    status: ?GeneratedTemplateStatus,

    /// The reason for the current template generation status. This will provide
    /// more details if a
    /// failure happened.
    status_reason: ?[]const u8,
};
