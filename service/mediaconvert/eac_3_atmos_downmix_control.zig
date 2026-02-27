/// Specify whether MediaConvert should use any downmix metadata from your input
/// file. Keep the default value, Custom to provide downmix values in your job
/// settings. Choose Follow source to use the metadata from your input. Related
/// settings--Use these settings to specify your downmix values: Left only/Right
/// only surround, Left total/Right total surround, Left total/Right total
/// center, Left only/Right only center, and Stereo downmix. When you keep
/// Custom for Downmix control and you don't specify values for the related
/// settings, MediaConvert uses default values for those settings.
pub const Eac3AtmosDownmixControl = enum {
    specified,
    initialize_from_source,

    pub const json_field_names = .{
        .specified = "SPECIFIED",
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
    };
};
