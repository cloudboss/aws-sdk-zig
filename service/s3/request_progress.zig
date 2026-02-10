/// Container for specifying if periodic `QueryProgress` messages should be
/// sent.
pub const RequestProgress = struct {
    /// Specifies whether periodic QueryProgress frames should be sent. Valid
    /// values: TRUE, FALSE. Default
    /// value: FALSE.
    enabled: ?bool,
};
