package com.github.ksoichiro.appicons;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        load();
    }

    private void load() {
        List<Icon> icons = new ArrayList<Icon>();
        icons.add(new Icon(R.drawable.ic_action_clock, "ic_action_clock"));
        icons.add(new Icon(R.drawable.ic_action_comment, "ic_action_comment"));
        icons.add(new Icon(R.drawable.ic_action_download, "ic_action_download"));
        icons.add(new Icon(R.drawable.ic_action_edit, "ic_action_edit"));
        icons.add(new Icon(R.drawable.ic_action_friend, "ic_action_friend"));
        icons.add(new Icon(R.drawable.ic_action_fullscreen, "ic_action_fullscreen"));
        icons.add(new Icon(R.drawable.ic_action_help, "ic_action_help"));
        icons.add(new Icon(R.drawable.ic_action_history, "ic_action_history"));
        icons.add(new Icon(R.drawable.ic_action_next, "ic_action_next"));
        icons.add(new Icon(R.drawable.ic_action_overflow, "ic_action_overflow"));
        icons.add(new Icon(R.drawable.ic_action_prev, "ic_action_prev"));
        icons.add(new Icon(R.drawable.ic_action_reload, "ic_action_reload"));
        icons.add(new Icon(R.drawable.ic_action_settings, "ic_action_settings"));
        icons.add(new Icon(R.drawable.ic_action_tag, "ic_action_tag"));
        IconAdapter adapter = new IconAdapter(this, icons);
        ListView list = (ListView) findViewById(R.id.list);
        list.setAdapter(adapter);
    }
}

