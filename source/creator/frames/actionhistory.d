module creator.frames.actionhistory;
import creator.frames;
import bindbc.imgui;
import creator.core.actionstack;
import std.string;

/**
    The logger frame
*/
class ActionHistoryFrame : Frame {
private:

protected:
    override
    void onUpdate() {


        igText("Undo History");
        igSeparator();

        ImVec2 avail;
        igGetContentRegionAvail(&avail);
        if (igBeginChildStr("##ActionList", ImVec2(0, avail.y-28), true, 0)) {
            if (incActionHistory().length > 0) {

                foreach(i, action; incActionHistory()) {
                    if (i == 0) {
                        if (igSelectableBool(action.describeUndo().toStringz, i <= cast(ptrdiff_t)incActionIndex(), 0, ImVec2(0, 0))) {
                            incActionSetIndex(0);
                        }
                    }
                    if (igSelectableBool(action.describe().toStringz, i+1 <= incActionIndex(), 0, ImVec2(0, 0))) {
                        incActionSetIndex(i+1);
                    }
                }
            }
            igEndChild();
        }

        igSeparator();
        if (igButton("Clear History", ImVec2(0, 0))) {
            incActionClearHistory();
        }
        igSameLine(0, 8);
        igText("%d of %d", incActionHistory().length, incActionGetUndoHistoryLength());
    }

public:
    this() {
        super("History", false);
    }
}

/**
    Generate logger frame
*/
mixin incFrame!ActionHistoryFrame;


