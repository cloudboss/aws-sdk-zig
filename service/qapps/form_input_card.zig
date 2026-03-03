const InputCardComputeMode = @import("input_card_compute_mode.zig").InputCardComputeMode;
const FormInputCardMetadata = @import("form_input_card_metadata.zig").FormInputCardMetadata;
const CardType = @import("card_type.zig").CardType;

/// A card in an Amazon Q App that allows the user to submit a response.
pub const FormInputCard = struct {
    /// The compute mode of the form input card. This property determines whether
    /// individual participants of a data collection session can submit multiple
    /// response or one response. A compute mode of `append` shall allow
    /// participants to submit the same form multiple times with different values. A
    /// compute mode of `replace`code> shall overwrite the current value for each
    /// participant.
    compute_mode: ?InputCardComputeMode = null,

    /// Any dependencies or requirements for the form input card.
    dependencies: []const []const u8,

    /// The unique identifier of the form input card.
    id: []const u8,

    /// The metadata that defines the form input card data.
    metadata: FormInputCardMetadata,

    /// The title of the form input card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType,

    pub const json_field_names = .{
        .compute_mode = "computeMode",
        .dependencies = "dependencies",
        .id = "id",
        .metadata = "metadata",
        .title = "title",
        .@"type" = "type",
    };
};
