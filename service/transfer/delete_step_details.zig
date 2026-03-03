/// The name of the step, used to identify the delete step.
pub const DeleteStepDetails = struct {
    /// The name of the step, used as an identifier.
    name: ?[]const u8 = null,

    /// Specifies which file to use as input to the workflow step: either the output
    /// from the previous step, or the originally uploaded file for the workflow.
    ///
    /// * To use the previous file as the input, enter `${previous.file}`. In this
    ///   case, this workflow step uses the output file from the previous workflow
    ///   step as input. This is the default value.
    /// * To use the originally uploaded file location as input for this step, enter
    ///   `${original.file}`.
    source_file_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .source_file_location = "SourceFileLocation",
    };
};
