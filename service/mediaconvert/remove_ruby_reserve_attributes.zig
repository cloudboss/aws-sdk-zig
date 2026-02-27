/// Optionally remove any tts:rubyReserve attributes present in your input, that
/// do not have a tts:ruby attribute in the same element, from your output. Use
/// if your vertical Japanese output captions have alignment issues. To remove
/// ruby reserve attributes when present: Choose Enabled. To not remove any ruby
/// reserve attributes: Keep the default value, Disabled.
pub const RemoveRubyReserveAttributes = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
