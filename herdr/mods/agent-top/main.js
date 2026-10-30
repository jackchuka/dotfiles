// Jumps to the agent at the top of the Priority order (blocked > done > working > idle, newest first), then closes.

import { View, div } from "gpui-kit";
import { agents, run, props, closeOverlay } from "herdr";

const RANK = { blocked: 4, done: 3, working: 2, idle: 1 };

export default class AgentTop extends View {
  init() {
    const [top] = [...agents()].sort((x, y) => (RANK[y.status] ?? 0) - (RANK[x.status] ?? 0) || y.seq - x.seq);
    if (top) run("agent.focus", { terminal: top.address });
    const overlay = props()?.overlay;
    if (overlay) closeOverlay(overlay);
  }

  render() {
    return div();
  }
}
