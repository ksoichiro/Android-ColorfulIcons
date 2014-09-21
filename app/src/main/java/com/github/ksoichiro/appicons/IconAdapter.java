package com.github.ksoichiro.appicons;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

public class IconAdapter extends ArrayAdapter<Icon> {

    public interface OnClickListener {
        void onClick(final View view, final Icon fileEntry);
    }

    private OnClickListener mOnClickListener;

    public IconAdapter(final Context context, List<Icon> objects) {
        super(context, R.layout.list_item_main, R.id.description, objects);
    }

    @Override
    public View getView(final int position, final View convertView, final ViewGroup parent) {
        View view = super.getView(position, convertView, parent);
        Icon entity = getItem(position);
        if (entity == null) {
            entity = new Icon();
        }
        ((ImageView) view.findViewById(R.id.icon)).setImageResource(entity.iconResId);
        ((TextView) view.findViewById(R.id.description)).setText(entity.description);
        view.setTag(entity);
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(final View view) {
                if (mOnClickListener != null) {
                    Object tag = view.getTag();
                    if (tag instanceof Icon) {
                        Icon entry = (Icon) tag;
                        mOnClickListener.onClick(view, entry);
                    }
                }
            }
        });
        return view;
    }

    public void setOnClickListener(final OnClickListener listener) {
        mOnClickListener = listener;
    }

}
