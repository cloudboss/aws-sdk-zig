/// By default, the service terminates any unterminated captions at the end of
/// each input. If you want the caption to continue onto your next input,
/// disable this setting.
pub const AncillaryTerminateCaptions = enum {
    end_of_input,
    disabled,

    pub const json_field_names = .{
        .end_of_input = "END_OF_INPUT",
        .disabled = "DISABLED",
    };
};
