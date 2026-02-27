pub const EmotionName = enum {
    happy,
    sad,
    angry,
    confused,
    disgusted,
    surprised,
    calm,
    unknown,
    fear,

    pub const json_field_names = .{
        .happy = "HAPPY",
        .sad = "SAD",
        .angry = "ANGRY",
        .confused = "CONFUSED",
        .disgusted = "DISGUSTED",
        .surprised = "SURPRISED",
        .calm = "CALM",
        .unknown = "UNKNOWN",
        .fear = "FEAR",
    };
};
