/// ABP device object for LoRaWAN specification v1.0.x
pub const UpdateAbpV1_0_x = struct {
    /// The FCnt init value.
    f_cnt_start: ?i32 = null,

    pub const json_field_names = .{
        .f_cnt_start = "FCntStart",
    };
};
