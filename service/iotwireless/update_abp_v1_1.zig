/// ABP device object for LoRaWAN specification v1.1
pub const UpdateAbpV1_1 = struct {
    /// The FCnt init value.
    f_cnt_start: ?i32,

    pub const json_field_names = .{
        .f_cnt_start = "FCntStart",
    };
};
