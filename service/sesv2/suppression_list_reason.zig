/// The reason that the address was added to the suppression list for your
/// account. The
/// value can be one of the following:
///
/// * `COMPLAINT` – Amazon SES added an email address to the suppression
/// list for your account because a message sent to that address results in a
/// complaint.
///
/// * `BOUNCE` – Amazon SES added an email address to the suppression
/// list for your account because a message sent to that address results in a
/// hard
/// bounce.
pub const SuppressionListReason = enum {
    bounce,
    complaint,

    pub const json_field_names = .{
        .bounce = "BOUNCE",
        .complaint = "COMPLAINT",
    };
};
