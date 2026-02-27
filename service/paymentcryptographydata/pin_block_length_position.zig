pub const PinBlockLengthPosition = enum {
    none,
    front_of_pin_block,

    pub const json_field_names = .{
        .none = "NONE",
        .front_of_pin_block = "FRONT_OF_PIN_BLOCK",
    };
};
