const FieldValidationMessage = @import("field_validation_message.zig").FieldValidationMessage;
const FileValidationMessage = @import("file_validation_message.zig").FileValidationMessage;

/// The model training data validation metrics.
pub const DataValidationMetrics = struct {
    /// The field-specific model training validation messages.
    field_level_messages: ?[]const FieldValidationMessage,

    /// The file-specific model training data validation messages.
    file_level_messages: ?[]const FileValidationMessage,

    pub const json_field_names = .{
        .field_level_messages = "fieldLevelMessages",
        .file_level_messages = "fileLevelMessages",
    };
};
