pub const ImageCustomActionTrigger = enum {
    click,
    menu,

    pub const json_field_names = .{
        .click = "CLICK",
        .menu = "MENU",
    };
};
