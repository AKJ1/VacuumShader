﻿using UnityEngine;

namespace Assets.Vacuum.Scripts
{
    public class OnClickVacuum : MonoBehaviour
    {
        public void Update()
        {
           if (Input.GetMouseButtonDown(0))
           {
                transform.GetComponent<Animator>().SetTrigger("Triggered");
           }
           transform.position = Camera.main.ScreenPointToRay(Input.mousePosition).GetPoint(9);
        }
    }
}
