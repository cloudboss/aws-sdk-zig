const FileUploadCardInput = @import("file_upload_card_input.zig").FileUploadCardInput;
const FormInputCardInput = @import("form_input_card_input.zig").FormInputCardInput;
const QPluginCardInput = @import("q_plugin_card_input.zig").QPluginCardInput;
const QQueryCardInput = @import("q_query_card_input.zig").QQueryCardInput;
const TextInputCardInput = @import("text_input_card_input.zig").TextInputCardInput;

/// The properties defining an input card in an Amazon Q App.
pub const CardInput = union(enum) {
    /// A container for the properties of the file upload input card.
    file_upload: ?FileUploadCardInput,
    /// A container for the properties of the form input card.
    form_input: ?FormInputCardInput,
    /// A container for the properties of the plugin input card.
    q_plugin: ?QPluginCardInput,
    /// A container for the properties of the query input card.
    q_query: ?QQueryCardInput,
    /// A container for the properties of the text input card.
    text_input: ?TextInputCardInput,

    pub const json_field_names = .{
        .file_upload = "fileUpload",
        .form_input = "formInput",
        .q_plugin = "qPlugin",
        .q_query = "qQuery",
        .text_input = "textInput",
    };
};
