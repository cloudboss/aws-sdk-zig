const FileUploadCard = @import("file_upload_card.zig").FileUploadCard;
const FormInputCard = @import("form_input_card.zig").FormInputCard;
const QPluginCard = @import("q_plugin_card.zig").QPluginCard;
const QQueryCard = @import("q_query_card.zig").QQueryCard;
const TextInputCard = @import("text_input_card.zig").TextInputCard;

/// A card representing a component or step in an Amazon Q App's flow.
pub const Card = union(enum) {
    /// A container for the properties of the file upload card.
    file_upload: ?FileUploadCard,
    /// A container for the properties of the form input card.
    form_input: ?FormInputCard,
    /// A container for the properties of the plugin card.
    q_plugin: ?QPluginCard,
    /// A container for the properties of the query card.
    q_query: ?QQueryCard,
    /// A container for the properties of the text input card.
    text_input: ?TextInputCard,

    pub const json_field_names = .{
        .file_upload = "fileUpload",
        .form_input = "formInput",
        .q_plugin = "qPlugin",
        .q_query = "qQuery",
        .text_input = "textInput",
    };
};
