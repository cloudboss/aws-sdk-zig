/// A message that indicates the request is complete and no more messages will
/// be sent. You should not
/// assume that the request is complete until the client receives an `EndEvent`.
pub const EndEvent = struct {};
